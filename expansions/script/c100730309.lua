--高速决斗技能-抽卡预感：骰子
Duel.LoadScript("speed_duel_common.lua")
function c100730309.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(76895648,c)
	aux.SpeedDuelReplaceDraw(c,c100730309.skill,c100730309.con,aux.Stringid(100730185,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730309.con(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetTurnCount()>=2
		and Duel.GetMatchingGroupCount(c100730309.filter,tp,LOCATION_DECK,0,nil)>5
end
function c100730309.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730309,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730309)
		local g=Duel.GetMatchingGroup(c100730309.filter,tp,LOCATION_DECK,0,nil)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
	end
end
function c100730309.filter(c)
	return c.toss_dice
end