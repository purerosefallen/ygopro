--高速决斗技能-抽卡预感：魔法·陷阱
Duel.LoadScript("speed_duel_common.lua")
function c100730059.initial_effect(c)
	if not c100730059.UsedLP then
		c100730059.UsedLP={}
		c100730059.UsedLP[0]=0
		c100730059.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730059.skill,c100730059.con,aux.Stringid(100730059,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730059.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730059,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730059)
		c100730059.UsedLP[tp]=c100730059.UsedLP[tp]+1000
		local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,1,nil,TYPE_SPELL+TYPE_TRAP)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730059.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_DECK,0,1,nil,TYPE_SPELL+TYPE_TRAP)>0
		and aux.DecreasedLP[tp]-c100730059.UsedLP[tp] >= 1000
end