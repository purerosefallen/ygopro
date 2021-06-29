--高速决斗技能-黑暗苏生
Duel.LoadScript("speed_duel_common.lua")
function c100730086.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730086.skill,c100730086.con,aux.Stringid(100730086,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730086.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(c100730086.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil)
end
function c100730086.skill(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,1-tp,100730086)
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
	local e1=Effect.GlobalEffect()   
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c100730086.limval)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,1-tp)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,TYPE_MONSTER)
	local tc=g:Select(tp,1,1,nil)
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
		e:Reset()
	end
end
function c100730086.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAttackBelow(4000)
end
function c100730086.limval(e,re,rp)
	return true
end