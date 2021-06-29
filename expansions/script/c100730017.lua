--高速决斗技能-假释！
Duel.LoadScript("speed_duel_common.lua")
function c100730017.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730017.operation,c100730017.con,aux.Stringid(100730017,0))
	local e1=Effect.GlobalEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c100730017.operation)
	c:RegisterEffect(e1)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730017.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730017.otfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c100730017.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c100730017.otfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local tc=sg:GetFirst()
	local atk=tc:GetAttack()
	if not tc then return end
	Duel.Hint(HINT_CARD,1-tp,100730017)
	Duel.SendtoDeck(tc,nil,0,REASON_RULE)
	Duel.Recover(tp,atk,REASON_EFFECT)
end
function c100730017.otfilter(c,tp)
	return c:GetOwner()~=c:GetControler()
end