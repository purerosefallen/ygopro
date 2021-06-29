--高速决斗技能-收渔之日
Duel.LoadScript("speed_duel_common.lua")
function c100730270.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730270.skill,c100730270.con,aux.Stringid(100730270,0))
	aux.RegisterSpeedDuelSkillCardCommon()
	aux.SpeedDuelBeforeDraw(c,c100730270.skill2)
end

function c100730270.Iskai(c)
	return c:IsCode(3643300)
end

function c100730270.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730270.Iskai,tp,LOCATION_MZONE+LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(c100730270.filter,tp,LOCATION_FZONE+LOCATION_GRAVE+LOCATION_DECK,0,1,nil)
end

function c100730270.wfilter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsLevelBelow(4)
end
function c100730270.filter(c)
	return c:IsCode(22702055)
end
function c100730270.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730270)
	local g1=Duel.GetMatchingGroup(c100730270.filter,tp,LOCATION_FZONE,0,nil)
	if g1:GetCount()~=0 then
		local g2=Duel.GetMatchingGroup(c100730270.wfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,nil)
		if g2:GetCount()==0 or Duel.GetMZoneCount(tp)==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g2:Select(tp,1,1,nil)
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
	if g1:GetCount()==0 then
		local tc=Duel.SelectMatchingCard(tp,c100730270.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,tp):GetFirst()
		Duel.MoveToField(tc,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
		local te=tc:GetActivateEffect()
		Duel.RaiseEvent(tc,4179255,te,0,tp,tp,Duel.GetCurrentChain())
		local g3=Duel.GetMatchingGroup(Card.IsType,tp,0,LOCATION_FZONE,nil,TYPE_FIELD)
		if g3:GetCount()==0 and Duel.IsExistingMatchingCard(c100730270.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(100730270,0)) then
			local sc=Duel.SelectMatchingCard(tp,c100730270.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,tp):GetFirst()
			Duel.MoveToField(sc,tp,1-tp,LOCATION_FZONE,POS_FACEUP,true)
		end
	end
end
function c100730270.skill2(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local c=e:GetHandler()
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetCategory(CATEGORY_RECOVER)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetValue(c100730270.abdcon)
	e3:SetCondition(c100730270.recon)
	e3:SetOperation(c100730270.reop)
	Duel.RegisterEffect(e3,tp)
	e:Reset()
end
function c100730270.recon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	return tc:IsControler(tp) and tc:IsRelateToBattle() and bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER) and tc:IsCode(3643300)
end
function c100730270.reop(e,tp,eg,ep,ev,re,r,rp) 
	local tc=eg:GetFirst() 
	local bc=tc:GetBattleTarget()
	local re=bc:GetAttack()
	if re<0 then re=0 end
	Duel.Recover(tp,re,REASON_EFFECT)
end
function c100730270.abdcon(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end