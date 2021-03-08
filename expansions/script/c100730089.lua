--高速决斗技能--丧尸招来
Duel.LoadScript("speed_duel_common.lua")
function c100730089.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(66835946,c)
	if not c100730089.UsedLP then
		c100730089.UsedLP={}
		c100730089.UsedLP[0]=0
		c100730089.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730089.skill,c100730089.con,aux.Stringid(100730089,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730089.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730089,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730089)
		c100730089.UsedLP[tp]=c100730089.UsedLP[tp]+1000
		local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,nil,RACE_ZOMBIE)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730089.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_DECK,0,nil,RACE_ZOMBIE)>0
		and aux.DecreasedLP[tp]-c100730089.UsedLP[tp] >= 1000
end