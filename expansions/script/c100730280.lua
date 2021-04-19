--高速决斗技能-前线督战
Duel.LoadScript("speed_duel_common.lua")
function c100730280.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730280.skill,c100730280.con,aux.Stringid(100730280,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730280.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,58054262)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,nil,22666164)
		and Duel.IsExistingMatchingCard(c100730280.spfilter,tp,LOCATION_MZONE,0,1,c,tp)
		and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_MZONE,0,2,nil,TYPE_MONSTER)
end
function c100730280.spfilter(c,tp)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and Duel.GetMZoneCount(tp,c)>0
end
function c100730280.fselect(g)
	return g:IsExists(Card.IsRace,1,nil,RACE_MACHINE)
end
function c100730280.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730280)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_MZONE,0,nil,TYPE_MONSTER)
	if chk==0 then return g:CheckSubGroup(c100730280.fselect,2,2) end
	local rg=g:SelectSubGroup(tp,c100730280.fselect,false,2,2)
	Duel.SendtoGrave(rg,nil,tp,REASON_COST)
	local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,22666164)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=g2:GetFirst()
	Duel.SpecialSummon(sc,0,tp,tp,true,true,POS_FACEUP_DEFENSE)
	Duel.Hint(HINT_CARD,1-tp,22666164)
	local g3=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,58054262)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	if g3:GetCount()>=1 then
		local tc=g3:GetFirst()
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local c=e:GetHandler()
		local g1=Duel.SelectMatchingCard(tp,c100730280.filter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,0,3,nil)
		local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
		if ft<g1:GetCount() then return end
		local qc=g1:GetFirst()
		qc:RegisterFlagEffect(100730280,RESET_EVENT+RESETS_STANDARD,0,0)
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c100730280.eqlimit)
		Duel.RegisterEffect(e1,qc)
		while qc do
		   Duel.Equip(tp,qc,tc,true,true)
		   qc=g1:GetNext()
		end
		local ct=tc:GetEquipGroup():GetClassCount(Card.GetCode)
		local e2=Effect.CreateEffect(tc)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		e2:SetValue(ct*200)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(tc)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD)
		e3:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
		e3:SetValue(ct-1)
		tc:RegisterEffect(e3)
		local e4=Effect.CreateEffect(tc)
		e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_DESTROY_REPLACE)
		e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e4:SetRange(LOCATION_MZONE)
		e4:SetTarget(c100730280.desreptg)
		e4:SetOperation(c100730280.desrepop)
		tc:RegisterEffect(e4)
	end
end
function c100730280.repfilter(c,e)
	return c:IsFaceup()
		and c:IsCode(60999392) or c:IsCode(96384007) or c:IsCode(23782705) or c:IsCode(22666164)
		and c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED)
end
function c100730280.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsOnField() and c:IsFaceup()
		and Duel.IsExistingMatchingCard(c100730280.repfilter,tp,LOCATION_SZONE,0,1,c,e) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c100730280.repfilter,tp,LOCATION_SZONE,0,1,1,c,e)
		e:SetLabelObject(g:GetFirst())
		g:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	else return false end
end
function c100730280.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(tc,REASON_EFFECT+REASON_REPLACE)
end
function c100730280.eqlimit(e,c)
	return e:GetOwner()==c
end
function c100730280.filter(c)
	return c:IsCode(60999392) or c:IsCode(96384007) or c:IsCode(23782705) or c:IsCode(22666164) and not c:IsForbidden()
end