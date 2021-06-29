--高速决斗技能-前线督战
Duel.LoadScript("speed_duel_common.lua")
function c100730277.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730277.skill,c100730277.con,aux.Stringid(100730277,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730277.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,58054262)
		and Duel.IsExistingMatchingCard(c100730277.filter1,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(c100730277.spfilter,tp,LOCATION_MZONE,0,1,c,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_MZONE,0,2,nil)
end
function c100730277.filter1(c)
	return c:IsCode(22666164)
end
function c100730277.spfilter(c,tp)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and Duel.GetMZoneCount(tp,c)>0
end
function c100730277.fselect(g)
	return g:IsExists(Card.IsRace,1,nil,RACE_MACHINE)
end
function c100730277.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730277)
	local g=Duel.GetMatchingGroup(Card.IsAbleToGraveAsCost,tp,LOCATION_MZONE,0,nil,TYPE_MONSTER)
	if chk==0 then return g:CheckSubGroup(c100730277.fselect,2,3) end
	local rg=g:SelectSubGroup(tp,c100730277.fselect,false,2,3)
	Duel.SendtoGrave(rg,REASON_COST)
	local ct=rg:GetCount()
	local g2=Duel.SelectMatchingCard(tp,c100730277.filter1,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=g2:GetFirst()
	if Duel.SpecialSummonStep(sc,0,tp,tp,false,false,POS_FACEUP_DEFENSE) then
		Duel.Hint(HINT_CARD,1-tp,22666164)
		local g3=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,58054262)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g3:GetFirst()
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local c=e:GetHandler()
		local sg=Duel.GetMatchingGroup(c100730277.filter2,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,nil)
		local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
		local g1=sg:SelectSubGroup(tp,aux.dncheck,false,0,ft)
		local qc=g1:GetFirst()
		qc:RegisterFlagEffect(100730277,RESET_EVENT+RESETS_STANDARD,0,0)
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c100730277.eqlimit)
		Duel.RegisterEffect(e1,qc)
		while qc do
		   Duel.Equip(tp,qc,tc,true,true)
		   if ft<=0 then return end
		   qc=g1:GetNext()
		end
		local count=tc:GetEquipGroup():GetClassCount(Card.GetCode)
		local e2=Effect.CreateEffect(tc)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		e2:SetValue(count*300)
		tc:RegisterEffect(e2)
		if ct==2 then return end
		local e3=Effect.CreateEffect(tc)
		e3:SetDescription(aux.Stringid(100730277,1))
		e3:SetCategory(CATEGORY_DESTROY)
		e3:SetType(EFFECT_TYPE_IGNITION)
		e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e3:SetRange(LOCATION_MZONE)
		e3:SetTarget(c100730277.destg)
		e3:SetOperation(c100730277.desop)
		tc:RegisterEffect(e3)
	end
	Duel.SpecialSummonComplete()
end
function c100730277.eqlimit(e,c)
	return e:GetOwner()==c
end
function c100730277.filter2(c)
	return c:IsCode(60999392,96384007,23782705,22666164) and not c:IsForbidden()
end
function c100730277.desfilter(c,g)
	return c:IsFaceup() and c:IsCode(60999392,96384007,23782705,22666164) and g:IsContains(c)
end
function c100730277.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=e:GetHandler():GetEquipGroup()
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c100730277.desfilter,tp,LOCATION_ONFIELD,0,1,nil,g)
		and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,c100730277.desfilter,tp,LOCATION_ONFIELD,0,1,1,nil,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,2,0,0)
end
function c100730277.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 and Duel.Destroy(g,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
	end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end